def list_directory(files)
  column_files = []
  columns_number = 3
  files.each_slice(columns_number) do |list|
    column_files << list
  end

  split_lists =
    column_files.map do |file|
      file.values_at(0...columns_number)
    end.flatten

  split_files = []

  split_lists.each_slice(split_lists.size / columns_number) do |list|
    split_files << list
  end

  split_files.transpose.each do |split_file|
    split_file.each { |file| print file.to_s.ljust(25) }
    print "\n"
  end
end
