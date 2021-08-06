require 'etc'
def list_directory_long_format(files)
  # 全ファイルに対してstat
  stat_files = files.map { |file| File::Stat.new(file) }
  # トータル用
  total = stat_files.sum(&:blocks)
  # -lの各情報を取得
  row_files = stat_files.map.with_index do |fs, i|
    array = []
    array << fs.ftype
    array << fs.mode.to_s(8)
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
    print filetype(file[0])
    print permission(file[1][-3].to_i) + permission(file[1][-2].to_i) + permission(file[1][-1].to_i).to_s.ljust(6)
    print file[2..7].join('  ')
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
