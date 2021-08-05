require 'etc'
# ls-l/ls-alr
def ls_l_alr(files)
  # 全ファイルに対してstat
  stat_files = files.map { |file| File::Stat.new(file) }
  # トータル用
  total = stat_files.sum(&:blocks)
  # -lの各情報を取得
  row_files = stat_files.map do |fs|
    array = []
    array << fs.ftype
    array << fs.mode.to_s(8)
    array << fs.nlink.to_s
    array << Etc.getpwuid(fs.uid).name
    array << Etc.getgrgid(fs.gid).name
    array << fs.size
    array << fs.mtime.strftime('%-m %-d %H:%M')
  end
  # トータル出力
  puts "total #{total}"
  # ファイルタイプ　パーミッション変換
  filetype = row_files.map { |file| filetype(file[0]) }
  permission = row_files.map { |file| permission(file[1][-3].to_i) + permission(file[1][-2].to_i) + permission(file[1][-1].to_i) }

  all_files = row_files.transpose.push(files)
  column_files = filetype, permission, all_files[2], all_files[3], all_files[4], all_files[5], all_files[6], all_files[7]
  # 結果を出力
  column_files.transpose.map { |file| print "#{file.join(' ')} \n" }
end

# ファイルタイプ
def filetype(type)
  { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'files', 'file' => '-', 'link' => 'l', 'socket' => 's' }[type]
end

# パーミッション
def permission(type)
  { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }[type]
end
