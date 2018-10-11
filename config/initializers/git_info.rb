if File.exists?('VERSION')
  VERSION = `cat VERSION`
else
  VERSION = ''
end
