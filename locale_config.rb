require 'i18n'

module LocaleConfig
  def init
    Dir[File.expand_path("config/locales") + "/*.yml"]
  end
end