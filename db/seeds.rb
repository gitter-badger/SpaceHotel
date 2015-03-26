# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

Role.create(Role::ALL)
Specification.create([{:id => 1, :name => 'econom'},
                      {:id => 2, :name => 'standart'},
                      {:id => 3, :name => 'luxury'}])
Status.create([{:id => 1, :name => 'occupied'},
               {:id => 2, :name => 'reserved'},
               {:id => 3, :name => 'unavailable'}])

Room.create(
        [
         {:id => 1, name: '101', :size => 32, :price => 20, description: 'This is the room of Queen Elizabeth. This is Her Majesty kitchen, and this is Her Toilet', :occupancy => 2, :specification_id => 3},
         {:id => 2, name: '102', :size => 20, :price => 15, description: 'This is a jellybean room. Taste it a bit and you\'ll understand what doe\'s it means', :occupancy => 1, :specification_id => 2},
         {:id => 3, name: '103', :size => 23, :price => 14, description: 'This small bare chamber holds nothing but a large ironbound chest, which is big enough for a man to fit in and bears a heavy iron lock. The floor has a layer of undisturbed dust upon it.', :occupancy => 2, :specification_id => 1},
         {:id => 4, name: '104', :size => 18, :price => 16, description: 'You enter a small room and your steps echo. Looking about, you\'re uncertain why, but then a wall vanishes and reveals an enormous chamber. The wall was an illusion and whoever cast it must be nearby!', :occupancy => 1, :specification_id => 3},
         {:id => 5, name: '201', :size => 45, :price => 42, description: 'A tunnel wends its way through solid ice, and huge icicles and pillars of frozen water block your vision of its farthest reaches.', :occupancy => 4, :specification_id => 2},
         {:id => 6, name: '202', :size => 22, :price => 32, description: 'In the center of this large room lies a 30-foot-wide round pit, its edges lined with rusting iron spikes. About 5 feet away from the pit\'s edge stand several stone semicircular benches.', :occupancy => 4, :specification_id => 1},
         {:id => 7, name: '204', :size => 32, :price => 20, description: 'The scent of earthy decay assaults your nose upon peering through the open door to this room. Smashed bookcases and their sundered contents litter the floor.', :occupancy => 2, :specification_id => 2},
         {:id => 8, name: '302', :size => 64, :price => 99, description: 'You round the corner to see a ghastly scene. A semitranslucent figure hangs in the air, studded with crossbow bolts and with blood pouring from every wound. It reaches toward you in a pleading gesture, points to the walls on either side of the room, and then vanishes. Once it has gone, you notice small holes in the walls, each just large enough for a bolt to pass through.', :occupancy => 5, :specification_id => 3},
         {:id => 9, name: '303', :size => 43, :price => 25, description: 'A huge iron cage lies on its side in this room, and its gate rests open on the floor. A broken chain lies under the door, and the cage is on a rotting corpse that looks to be a hobgoblin. Another corpse lies a short distance away from the cage. It lacks a head.', :occupancy => 1, :specification_id => 3},
         {:id => 10, name: 'Bean Room', :size => 99, :price => 120, description: 'Beans, beans... they\'re good for your heart' , :occupancy => 1, :specification_id => 3},
        ]
)