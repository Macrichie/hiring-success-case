class ImportDataJob < ApplicationJob
  queue_as :hiring_list

  def perform(hiring_upload)
    CSVReader.new(hiring_upload.csv_file).each_line do |row, index|
      begin
        create_record row
      rescue StandardError => e
        logger.error "The following error was found at line ##{index}: #{e}"
      end
    end
  end

  private

  def create_record(row)
    city = City.where(name: row['city']).first_or_create
    skill = Skill.where(name: row['skill']).first_or_create do |skill|
      skill.area = Area.where(name: row['area']).first_or_create
    end
    Hiring.create(name: row['name'],
                  city: city,
                  skill: skill,
                  year: row['year'])
  end
end