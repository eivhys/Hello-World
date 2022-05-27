# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts '=== Running seeds.rb 🌱 ==='

ruby_constraint = Constraint.create(
  title: 'Ruby 3.1.1',
  description: "You will be using ruby 3.1.1, use of IO like the 'File' class or 'puts' method will cause the test to fail."
)

junior_challenge_title = "Commander Nibble's Evil Empire"
junior_challenge_story = <<~EOL
  The evil commander Nibble is planning to launch an attack on the happy sheep planet, home of the happiest sheep in the entire galaxy! Your mission is to infiltrate commander Nibbles' evil base on Würst planet, the worst planet in the universe.
  <br/><br/>
  In order to get past the planet's magnet shields, which will shove away anything magnetic, you've been thrown off from orbit and somehow you stuck the landing. Without your raygun and fancy-schmancy space tech, you'll have to improvise.
  <br/><br/>
  You find yourself right next to the Evil HQ™️ and in order to get inside the base you climb through the ventilation. Once you're out you hear a voice. "Lackey! Where have you been? You're supposed to scrub the cafeteria floors!", an angry voice said. It was John, the janitor, he gives you a mop and sends you to the cafeteria in order to clean the floor. This is where your mission begins.
  <br/><br/>
  Good luck!
EOL

junior_level_title = 'Infiltrating the ranks'

junior_exercise_title = 'Cleaning the floor'
junior_exercise_story = <<~EOL
  In order to make the janitor happy you've got to mop all of the cafeteria floors. To do this the janitor has given you an <i>interstellar mop</i> and <i>galactic bucket</i>. This mop is no ordinary mop, it can clone itself one time and send the clone in a direction perpendicular to that of the original mop and will mirror your movement as long as you turn at 90 degree angles, meaning that you can only create squares. When the two mops collide they'll merge to one mop again and all of the floor areas within the perimeter you created will be mopped automatically.
  <br/><br/>
  Create a method solution that takes an integer representing the area of the cafeteria floors in square meters as its input. It should return the minimum amount of times you have to use your interstellar mop in order to get the floors clean, and how many square meters each cleans.
  <br/><br/>
  Example 1:<br/>
  <b>Input: 12, solution => [9, 1, 1, 1]</b>
  <br/><br/>
  Example 2:<br/>
  <b>Input: 81, solution => [81]</b>
EOL

junior_challenge = Challenge.create!(title: junior_challenge_title, description: junior_challenge_story,
                                     constraint: ruby_constraint)
junior_level = junior_challenge.levels.create!(title: junior_level_title, position: 1)
junior_exercise = junior_level.exercises.create!(title: junior_exercise_title, description: junior_exercise_story,
                                                 position: 1, unlock_criteria: 0, implementation: 'def solution(*); 1; end')
junior_assessment = junior_exercise.assessments.create!(hidden: false, input: '1', leeway: 500)
junior_invitation = Invitation.create!(code: '12345', user: nil, challenge: junior_challenge)

senior_challenge_title = 'Subjugating the solar system'
senior_challenge_story = <<~EOL
  As your seniority grows, so does your lust for power, as a above average developer with an above average god complex, it's only reasonable that you attempt to conquer the galaxy.
  <br/><br/>
  Just like every feature you make you'll probably be done next week or so, so let's get cracking!
EOL

senior_level_title_1 = 'Terraforming Mars'

senior_exercise_title_1 = 'Planting seeds'
senior_exercise_story_1 = <<~EOL
  You've been tasked with planting seeds on the surface of mars. You've got a lot of seeds to plant, and you don't have a lot of time to plant them.
  <br/><br/>
  In order to plant them faster you've been given a <i>seed pod</i> that can plant seeds in a certain area. The pod can carry lots of seeds, with a seed count as high as 300 digit numbers.<br/>
  Although the pod can carry enough seeds for the entire surface of Mars, it can only plant one at a time. In order to retrieve a seed you can perform one of three commands on the pod:
  <br/>
  - Add 1 seed<br/>
  - Subtract 1 seed<br/>
  - Divide the amount of seeds by 2<br/>
  <br/><br/>
  After a sequence of these commands you can retrieve the seed from the pod when there's only one seed left to take.
  <br/><br/>
  Example 1:<br/>
  <b>Input: 8, solution => (8 / 2) => (4 / 2) => (2 / 2) = 3 commands</b>
  <br/><br/>
  Example 2:<br/>
  <b>Input: 15, solution => (15 + 1) => (16 / 2) => (8 / 2) => (4 / 2) => (2 / 2) = 5 commands</b>
EOL

senior_level_title_2 = 'Becoming a venusian'

senior_exercise_title_2 = 'Cleaning the surface'
senior_exercise_story_2 = <<~EOL
  After making good progress on Mars you're off to Venus. To you surprise, it's already inhabited by giant flytraps, I guess that's where they originate from.<br/><br/>
  They are quite scary and dangerous, so it might be best to attempt making an alliance with them, making a good first impression is crucial!<br/><br/>
  The venusian flytraps are very intelligent and thankful for your effort for the plant kingdom on Mars, so they'll provide you with a task to see if you're worthy of their trust.<br/><br/>
  Appearently there's a war raging between the venusian flytraps and the venusian mushroom empire. As the flytraps are carnivores they are incapable of the mushrooms, which is the quickest way to dispose them, this is where you come in handy.<br/><br/>
  The task is simple, eat as many mushrooms as possible in order to lead the flytraps to victory, but be ware, eating a number of mushrooms that's not divisible by 3 will send you to another planet, foiling your chances of making alliances on the planet you're currently on, don't mess it up!
  <br/><br/>
  Create a method solution that takes a list of integers representing a number of mushrooms as its input. It should return the maximum number of mushrooms you are able to eat as a string. A number can only be used as many times as it appears in the input, if there is no solution return "Impossible".
  <br/><br/>
  Example 1:<br/>
  <b>Input: [3, 2, 1], solution => 321 </b>
  <br/><br/>
  Example 2:<br/>
  <b>Input: [6, 3, 2, 9, 7], solution => 9762 </b>
EOL

senior_challenge = Challenge.create!(title: senior_challenge_title, description: senior_challenge_story,
                                     constraint: ruby_constraint)
senior_level_1 = senior_challenge.levels.create!(title: senior_level_title_1, position: 1)
senior_exercise_1 = senior_level_1.exercises.create!(title: senior_exercise_title_1,
                                                     description: senior_exercise_story_1, position: 1, unlock_criteria: 0, implementation: 'def solution(*); 1; end')
senior_assessment_1 = senior_exercise_1.assessments.create!(hidden: false, input: '1', leeway: 500)
senior_invitation_1 = Invitation.create!(code: '1337', user: nil, challenge: senior_challenge)

senior_level_2 = senior_challenge.levels.create!(title: senior_level_title_2, position: 1)
senior_exercise_2 = senior_level_2.exercises.create!(title: senior_exercise_title_2,
                                                     description: senior_exercise_story_2, position: 1, unlock_criteria: 0, implementation: 'def solution(*); 1; end')
senior_assessment_2 = senior_exercise_2.assessments.create!(hidden: false, input: '1', leeway: 500)
