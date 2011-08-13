require 'csv'

class HomeController < ApplicationController
  def csv
    isbns = params[:csv][:isbns].split(/\D+/)
    csv = CSV.generate(:col_sep => "\t") do |csv|
      csv << %w(isbn author title)
      isbns.each do |isbn|
        ISBNDB_QUERY.find_book_by_isbn(isbn).first.tap do |result|
          csv << [longify(result.isbn), result.authors_text, result.title]
        end
      end
    end

    filename = 'yer_books.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end

    render :layout => false, :text => csv
  end

  private
  def longify(isbn)
    isbn.length == 10 ?  "978" + isbn : isbn
  end
end
