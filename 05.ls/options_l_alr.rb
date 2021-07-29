# ls-l/ls-alr
def ls_l_alr(files)
  require 'etc'
  # 全ファイル取得
  all_files = files.map { |item| item }
  # トータル用
  total = 0
  # -lの内容を取得
  row_files =
    all_files.map do |file|
      array = []
      fs = File::Stat.new(file)
      total += fs.blocks
      array << fs.ftype
      array << fs.mode.to_s(8)
      array << fs.nlink.to_s
      array << fs.size
      array << Etc.getpwuid(fs.uid).name
      array << Etc.getgrgid(fs.gid).name
      array << fs.mtime.strftime('%-m %-d %H:%M')
    end
  # トータル出力
  puts "total #{total}"
  # 行列置換
  column_files = row_files.transpose
  filetype_convert = column_files[0].map { |file| filetype(file) }
  permission_convert = column_files[1].map { |file| permission(file[-3].to_i) + permission(file[-2].to_i) + permission(file[-1].to_i) }
  array_files = filetype_convert, permission_convert, column_files[2], column_files[3], column_files[4], column_files[5], column_files[6], files

  array_files.transpose.each do |array_file|
    array_file.each { |file| print file.to_s.ljust(6).rjust(4) }
    print "\n"
  end
end

# ファイルタイプ
def filetype(type)
  { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'files', 'file' => '-', 'link' => 'l', 'socket' => 's' }[type]
end

# パーミッション
def permission(type)
  { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }[type]
end
