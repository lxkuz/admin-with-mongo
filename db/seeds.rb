User.create!(email: 'admin@mystand.ru', password: 'beer4stepa') unless User.where(email: 'admin@mystand.ru').any?

sections = []

Section.create!(root: true) unless Section.root
root = Section.root
sections.each_with_index do |section, index|
  section_key = "section-#{index}"
  unless Section.get section_key
    root.base_children.create! key: section_key, title: section
  end
end

root.save

PageFragment.config do
  fragment :test, 'тест'
  fragment :test, :test, 'тест вложженых ключей'
end
