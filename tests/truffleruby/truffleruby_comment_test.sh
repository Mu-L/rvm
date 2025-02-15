## Test the latest TruffleRuby release
rvm install truffleruby # status=0; match!=/Already installed/; match=/compiling c-extensions/
rvm truffleruby do ruby -v # status=0; match=/truffleruby/
rvm truffleruby do rake --version # status=0; match=/rake, version/
rvm truffleruby do ruby -S bundle --version # status=0; match=/Bundler version/
echo 'gem "rake"' > Gemfile # status=0
rvm truffleruby do bundle install # status=0
rvm truffleruby do ruby -S bundle exec rake --version # status=0; match=/rake, version/
rm Gemfile
rvm truffleruby do ruby -ropen-uri -e 'puts URI.send(:open, %{https://rubygems.org/}) { |f| f.read(1024) }' # status=0; match=/RubyGems.org/
rvm remove truffleruby # status=0; match=/removing.+truffleruby/

## Test installing truffleruby-head
rvm install truffleruby-head # status=0; match!=/Already installed/
rvm truffleruby-head do ruby -v # status=0; match=/truffleruby/
rvm remove truffleruby-head # status=0

## Test that the right version is installed (#4633)
rvm install truffleruby-23.1.2 # status=0; match!=/Already installed/
rvm truffleruby-23.1.2 do ruby -v # status=0; match=/truffleruby 23.1.2/
rvm remove truffleruby-23.1.2 # status=0
