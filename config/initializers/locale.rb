# in config/initializers/locale.rb
 
# indicar a la librería i18n dónde están las traducciones
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
 
