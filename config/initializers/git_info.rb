if File.exists?('VERSION')
  VERSION = `cat VERSION`.chomp
else
  VERSION = ''
end

GIT_REVISION = `git rev-parse --short HEAD`.chomp || 'revision not found'
GIT_BRANCH = `git rev-parse --abbrev-ref HEAD`.chomp || 'branch not found'
