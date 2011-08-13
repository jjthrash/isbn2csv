QuickConfig.api(:isbndb, 'ISBNDB_API_KEY') do
  ISBNDB_QUERY = ISBNdb::Query.new([ENV['ISBNDB_API_KEY']])
end
