# frozen_string_literal: true

require 'yaml'

# serialize and save the data to file
def save_game(current_game)
  obj = current_game.instance_variables.each_with_object({}) do |variable, hash|
    hash[variable] = current_game.instance_variable_get(variable)
  end
  Dir.mkdir('saved_game') unless Dir.exist?('saved_game')
  File.open('saved_game/saved_game.yaml', 'w') { |file| file.write YAML.dump obj }
end

# load a data from a file and deserialize it
def load_game
  obj = File.open('saved_game/saved_game.yaml', 'r') { |data| YAML.safe_load(data, permitted_classes: [Symbol]) }
  obj.each do |instance_variable, value|
    instance_variable_set(instance_variable, value)
  end
end
