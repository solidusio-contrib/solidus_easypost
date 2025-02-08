# frozen_string_literal: true

FactoryBot.definition_file_paths.unshift(*Dir["#{__dir__}/factories/*_factory.rb"].map{ _1.chomp(".rb") }).uniq!
Spree::TestingSupport::FactoryBot.add_paths_and_load!
