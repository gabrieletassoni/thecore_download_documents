require "thecore_download_documents/railtie"

require 'thecore'
require "prawn"
require "prawn/table"
require 'csv'
module ThecoreDownloadDocuments
  # Your code goes here...
  def self.pdf_table header, footer, rows, table_headers, filename
    pdf = Prawn::Document.new page_layout: :landscape, page_size: "A4"
    pdf.repeat :all do
      # Header
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width do
        pdf.float do
          pdf.text (header[:left] || ""), size: 8, align: :left
        end
        pdf.float do
          pdf.text (header[:center] || ""), size: 8, align: :center
        end
        pdf.text (header[:right] || ""), size: 8, align: :right
      end
      # Footer
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 18], width: pdf.bounds.width do
        pdf.float do
          pdf.text (footer[:left] || ""), size: 8, align: :left
        end
        pdf.float do
          pdf.text (footer[:center] || ""), size: 8, align: :center
        end
        pdf.text (footer[:right] || ""), size: 8, align: :right
      end
    end
    
    # Create another box that is placed on the page after our footer is
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top-8], width: pdf.bounds.width, height: pdf.bounds.height - 16 do
      #Generate the rest of your PDF content here
      pdf.table rows.unshift(table_headers), header: true do |table| table.row(0).font_style = :bold end
    end

    return pdf.render, {filename: "#{filename}.pdf", type: "application/pdf"}
  end

  def self.csv_table rows, table_headers, filename
    csv = CSV.generate do |row|
      row << table_headers
      rows.each do |r|
        row << r.values
      end
    end

    return csv, {filename: "#{filename}.csv", type: "text/csv"}
  end
end
