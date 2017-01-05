task import_app_dataset: :environment do
  apps_url = 'https://gist.githubusercontent.com/alexandremeunier/3ff9289c362cdca3bf02370443c3589b/raw/81753570b030a2ce12cc64b146199d6568e8e524/data.json'
  apps_json = JSON.parse open(apps_url).read

  progress_bar = ProgressBar.create total: apps_json.size
  apps_json.each do |app_json|
    App.create name: app_json['name'], image: app_json['image'], link: app_json['link'], category: app_json['category'], rank: app_json['rank']
    progress_bar.increment
  end
end