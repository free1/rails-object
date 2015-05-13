# encoding: utf-8

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#

database = YAML.load_file("#{File.dirname(Config.config_file)}/../database.yml").fetch('production')

Backup::Model.new(:my_backup, '备份整站数据') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = database["database"]
    db.username           = database["username"]
    db.password           = database["password"]
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = database["socket"]
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    #db.skip_tables        = ["skip", "these", "tables"]
    #db.only_tables        = ["only", "these", "tables"]
    db.additional_options = ["--quick", "--single-transaction"]
  end

  compress_with Gzip

  store_with Local do |local|
    local.path = "/tmp/test"
  end

end
