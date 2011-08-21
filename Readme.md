ActiveRecord Ignored Attributes
===============================

Adds various behavior to Active Record models relating to the model's attributes: 

* Allows you to compare Active Record objects based on their *attributes*, which often makes more sense than the built-in `==` operator (which does its comparisons based on the `id` attribute alone! — not always what you want!)
* You can configure which attributes, if any, should be excluded from the comparison
* Provides a customizable inspect method, which by default excludes the same attributes that are excluded when doing a `same_attributes_as?` comparison

Example
=======

Consider a User model that holds the notion of users that have a name.

    ActiveRecord::Schema.define do
      create_table :addresses, :force => true do |t|
        t.string   :name
        t.text     :address
        t.string   :city
        t.string   :state
        t.string   :postal_code
        t.string   :country
        t.timestamps
      end
    end

    class Address < ActiveRecord::Base
    end


Default ActiveRecord `==` behavior:

    a = Address.new(address: 'B St.')
    b = Address.new(address: 'B St.')
    a == b # => false

Using `same_as?`:

    a = Address.new(address: 'B St.')
    b = Address.new(address: 'B St.')
    a.same_as?(b) # => true

    a = Address.new(address: 'B St.')
    b = Address.new(address: 'Nowhere Road')
    a.same_as?(b) # => false


Installing
==========

Add to your `Gemfile`:

<pre>
gem "active_record_attributes_equality"
</pre>

If you want to *replace* the default ActiveRecord `==` operator with the `same_as?` behavior, you should be able to just override it, like this:

    class ActiveRecord::Base
      alias_method :==, :same_as?
    end

Configuring which attributes are ignored
========================================

By default, `id`, `created_at`, and `updated_at` will be ignored.

If you want to *add* some ignored attributes to the default array (`[:id, :created_at, :updated_at]`), you can override `self.ignored_attributes` like so, referencing `super`:

    class Address < ActiveRecord::Base
      def self.ignored_attributes
        super + [:name]
      end
    end

If you want to override the defaults instead of appending to them, just don't reference `super`:

    class Address < ActiveRecord::Base
      def self.ignored_attributes
        [:id, :name]
      end
    end

`inspect_without_ignored_attributes`
------------------------------------

Now that you've declared which attributes you don't really care about, how about making it so you don't have to see them in your `inspect` output too? (The output from `inspect` is verbose enough as it is!!)

`object.inspect_without_ignored_attributes` will give you the same output as the default `inspect` but without all those ignored attributes (except for `id` — `id` is always included, even if it's listed in `ignored_attributes`)):

    address.inspect_without_ignored_attributes # => "#<Address id: 1, address: nil, city: nil, country: nil, postal_code: nil, state: nil>"

    # Compared to:
    address.inspect                            # => "#<Address id: 1, name: nil, address: nil, city: nil, state: nil, postal_code: nil, country: nil, created_at: \"2011-08-19 18:07:39\", updated_at: \"2011-08-19 18:07:39\">"
  
But that is a lot to type every time. If you want inspect to *always* be more readable, you can override the ActiveRecord default like this:

    class Address < ActiveRecord::Base
      alias_method :inspect, :inspect_without_ignored_attributes
    end

or even:

    class ActiveRecord::Base
      alias_method :inspect, :inspect_without_ignored_attributes
    end

Customizable inspect method
---------------------------

If you want to customize inspect further and specify exactly which attributes to show (and, optionally which delimiters to bracket the string with), you can use `inspect_with`:

    class Address < ActiveRecord::Base
      def inspect
        inspect_with([:city, :state, :country])
      end
    end

or:

    class Address < ActiveRecord::Base
      def inspect
        inspect_with([:id, :name, :address, :city, :state, :postal_code, :country], ['{', '}'])
      end
    end


RSpec
=======

This gem comes with a `be_same_as` matcher for RSpec.

Add this to your spec_helper.rb:

    require 'active_record_ignored_attributes/matchers'

Then in your specs you can write such nicely readable expectations as:

    expected = Address.new({city: 'City', country: 'USA'})
    Address.last.should be_same_as(expected)

    a = Address.new(address: 'B St.')
    b = Address.new(address: 'B St.')
    a.should be_same_as?(b) # passes

    a = Address.new(address: 'B St.')
    b = Address.new(address: 'Nowhere Road')
    a.should be_same_as?(b) # fails

and it will lovingly do a diff for you and only show you the attributes in each object that actually differed:

    expected: #<Address address: "Nowhere Road">
         got: #<Address address: "B St.">



Motivation
==========

The default ActiveRecord `==` behavior isn't always adequate, as you can probably tell from the example at the top, or by the fact that you are looking at this gem right now.

This is the implementation of `==` in [ActiveRecord](https://github.com/rails/rails/blob/3-0-10/activerecord/lib/active_record/base.rb):

    # Returns true if +comparison_object+ is the same exact object, or +comparison_object+
    # is of the same type and +self+ has an ID and it is equal to +comparison_object.id+.
    #
    # Note that new records are different from any other record by definition, unless the
    # other record is the receiver itself. Besides, if you fetch existing records with
    # +select+ and leave the ID out, you're on your own, this predicate will return false.
    #
    # Note also that destroying a record preserves its ID in the model instance, so deleted
    # models are still comparable.
    def ==(comparison_object)
      comparison_object.equal?(self) ||
        (comparison_object.instance_of?(self.class) &&
          comparison_object.id == id && !comparison_object.new_record?)
    end

That implementation is often fine when you are dealing with saved records, but isn't helpful *at all* when one or both of the objects being compared is not-yet-saved.

If you want to compare two model instances based on their attributes, you will probably want to *exclude* certain irrelevant attributes from your comparison, such as: `id`, `created_at`, and `updated_at`. (I would consider those to be more *metadata* about the record than part of the record's data itself.)

This might not matter when you are comparing two new (unsaved) records (since `id`, `created_at`, and `updated_at` will all be `nil` until saved), but I sometimes find it necessary to compare a *saved* object with an *unsaved* one (in which case == would give you false since nil != 5). Or I want to compare two *saved* objects to find out if they contain the same *data* (so the ActiveRecord `==` operator doesn't work, because it returns false if they have different `id`'s, even if they are otherwise identical).

See also: http://stackoverflow.com/questions/4738439/how-to-test-for-activerecord-object-equality


Questions and Ideas
===================

* Does such a gem already exist?
  * All I've found so far is https://github.com/GnomesLab/active_record_attributes_equality
* What should the method be called? I don't think overriding the existing `==` operator is a good idea (as done in [active_record_attributes_equality](https://github.com/GnomesLab/active_record_attributes_equality)), so for now I'm calling it `same_attributes_as?` (aliased as `same_as?` since that's easier to type). Other runners up were `practically_same_as?` and `attributes_eql?`.


Possible improvements:

* Allow the default to be overridden with a class macro like `ignore_for_attributes_eql :last_signed_in_at, :updated_at` 

Also, perhaps you want to set the default ignored attributes for a model but still wish to be able to override these defaults as needed...

    address.same_as?(other_address, :ignore => [:addressable_type, :addressable_id])
    address.same_as?(other_address, :only => [:city, :state, :country])


Contributing
============

Comments and contributions are welcome.

Please feel free to fork the project at http://github.com/TylerRick/active_record_ignored_attributes and to send pull requests.

Bugs can be reported at https://github.com/TylerRick/active_record_ignored_attributes/issues

License
=======

Copyright 2011, Tyler Rick

This is free software, distributed under the terms of the MIT License.
