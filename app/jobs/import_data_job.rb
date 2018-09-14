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
    Hiring.create(name: row['name'].strip,
                  city: create_city(row),
                  skill: create_skill(row),
                  year: row['year'].strip)
  end

  def create_city(row)
    city_name = row['city']
    return default_city if city_name.blank?
    City.where(name: city_name.strip).first_or_create
  end

  def default_city
    City.where(name: 'Unspecified').first_or_create
  end

  def create_skill(row)
    skill_name = row['skill']
    return default_skill if skill_name.blank?
    skill = Skill.where(name: skill_name.strip).first_or_create do |skill|
      skill.area = create_area(row)
    end
  end

  def default_skill
    Skill.where(name: 'Unspecified').first_or_create do |skill|
      skill.area = default_area
    end
  end

  def create_area(row)
    area_name = row['area']
    return default_area if area_name.blank?
    Area.where(name: area_name.strip).first_or_create
  end

  def default_area
    Area.where(name: 'Unspecified').first_or_create
  end
end