require 'etc'
def list_directory_long_format(files)
  # 全ファイルに対してstat
  stat_files = files.map { |file| File::Stat.new(file) }
  # トータル用
  total = stat_files.sum(&:blocks)
  # -lの各情報を取得
  row_files = stat_files.map.with_index do |fs, i|
    array = []
    array << filetype(fs.ftype)
    array << fs.mode.to_s(8)[-3, 3].chars.map { |f| permission(f.to_i) }.join('')
    array << fs.nlink.to_s
    array << Etc.getpwuid(fs.uid).name
    array << Etc.getgrgid(fs.gid).name
    array << fs.size
    array << fs.mtime.strftime('%-m %-d %H:%M')
    array << files[i]
  end
  # トータル出力
  puts "total #{total}"
  # 結果を出力
  row_files.map do |file|
    print file[0..7].join(' ')
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
