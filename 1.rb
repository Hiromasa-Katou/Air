require "pdfkit"
 
PDFKit.new('https://www.google.com', :page_size => 'A3').to_file('google.pdf')