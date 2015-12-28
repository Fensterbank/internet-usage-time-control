# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create the first admin user. Should be changed via rails console
admin = User.new
admin.password = 'admin'
admin.name = 'admin'
admin.save!