# This is a comment
# ruby compile options
# '--prefix=/Users/carlobifulco/.rbenv/versions/2.1.3' '--with-readline-dir=/usr/local/opt/readline' '--with-openssl-#dir=/usr/local/opt/openssl' 'CFLAGS= -O3 -Wno-error=shorten-64-to-32 ' 'LDFLAGS=-L/Users/carlobifulco/.rbenv/versions/2.1.# 3/lib ' 'CPPFLAGS=-I/Users/carlobifulco/.rbenv/versions/2.1.3/include '


FROM  ubuntu:latest
MAINTAINER carlo bifulco  <carlobif@gmail.com>



# system
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y --force-yes build-essential wget git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
# dev is needed for building extensions...
RUN apt-get install -y ruby ruby-dev
RUN apt-get install -y apt-utils

# basic utilities
RUN apt-get install -y   emacs23-nox
RUN apt-get install -y screen
RUN apt-get install -y tree
RUN apt-get install -y curl

#mongo
RUN apt-get install -y mongodb
RUN mkdir -p /data/db

RUN apt-get install locate






# # Install rbenv and ruby-build
# RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
# # add to bashrc
# RUN  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /root/.bashrc
# RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
# # ruby build
# RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
# RUN ./root/.rbenv/plugins/ruby-build/install.sh
# # cannot restart bash during docker build
# ENV PATH /root/.rbenv/bin:$PATH
# RUN bash -l -c  'eval "$(rbenv init -)"'

# ADD ./versions.txt /root/versions.txt
# ADD ./supervisor.conf /root/supervisor.conf
# #ADD ./Gemfile /root/Gemfile
# #ADD ./Gemfile /root/.rbenv/default-gems




# # Build and Install multiple versions of ruby
# ENV CONFIGURE_OPTS --with-readline-dir=/usr/include/readline
# RUN xargs -L 1 rbenv install < /root/versions.txt

# # RUN sudo apt-get autoremove ruby

# WORKDIR /root
# RUN rbenv global 2.1.3
# RUN rbenv local 2.1.3

# ### global gem files
RUN echo 'gem: --no-rdoc --no-ri' >> /root/.gemrc
# ENV REALLY_GEM_UPDATE_SYSTEM True
# RUN gem update --system
# RUN gem pristine --all --no-extensions
# # rahash gems
#RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git /root/.rbenv/plugins/rbenv-gem-rehash
# default gems
#RUN git clone https://github.com/sstephenson/rbenv-default-gems.git /root/.rbenv/plugins/rbenv-default-gems

RUN gem install bundler
# RUN rbenv rehash
RUN gem install pry
# RUN rbenv rehash
RUN gem install immunoscore_results_aggregator




# ### Install Bundler for each version of ruby; install shared gems
# RUN bash -l -c 'cd /root/; for v in $(cat /root/versions.txt); do rbenv global $v;echo $v;  gem install bundler; done'
# RUN  bash -l -c 'cd /root/; for v in $(cat /root/versions.txt); do rbenv global $v; echo $v;  gem install bundle; done'
# RUN bash -l -c 'cd /root/; for v in $(cat /root/versions.txt); do echo $v; rbenv global $v;  bundle install; done'






# # working repos
# RUN git clone https://github.com/carlobifulco/next_gen_ion_torrent_ampliseq_hotspot_pipeline.git



# WORKDIR /root/next_gen_ion_torrent_ampliseq_hotspot_pipeline
# RUN bash -l -c 'for v in $(cat /root/versions.txt); do echo $v; rbenv local $v;  gem install bundle; rbenv rehash;  bundle install; done'
# RUN rbenv local 2.1.3



#RUN rbenv local 1.9.3-p547
#RUN gem install bundle 
#RUN rbenv rehash
#RUN bundle 
#RUN rbenv local 2.1.3
#RUN gem install bundle 
#RUN rbenv rehash
#RUN bundle 



# RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv local $v; rbenv rehash; bundle install; done'
#RUN bundle update
#RUN bundle install

#WORKDIR /root/immunoscore_results
#RUN bash -l -c 'for v in $(cat /root/versions.txt); do echo $v; rbenv local $v;  gem install bundler; rbenv rehash;  bundle install; done'
#RUN rbenv local 2.1.3

# not working, not sure why
#RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv local $v; rbenv rehash; bundle install; done'


#RUN rbenv local 1.9.3-p547
#RUN gem install bundle 
#RUN rbenv rehash
#RUN bundle 
#RUN rbenv local 2.1.3
#RUN gem install bundle 
#RUN rbenv rehash
#RUN bundle 



#RUN bundle update
# RUN bundle install


# go back to latest version



### ports mongo and mountable directories.
VOLUME ["/data/db"]
EXPOSE 27017
EXPOSE 28017
#Redis
EXPOSE 6379

RUN git clone https://github.com/carlobifulco/immunoscore_results.git
#

###supervisor
RUN apt-get install -y supervisor
ADD ./supervisor.conf /root/supervisor.conf
RUN cp /root/supervisor.conf  /etc/supervisor/supervisord.conf
# RUN curl https://gist.github.com/howthebodyworks/176149/raw/88d0d68c4af22a7474ad1d011659ea2d27e35b8d/supervisord.sh > /etc/init.d/supervisord
# RUN chmod +x /etc/init.d/supervisord
# RUN sudo update-rc.d supervisord defaults
RUN echo "supervisord" >> /root/.bashrc

CMD ["/usr/bin/supervisord"]



#CMD /usr/bin/mongod &&  /usr/bin/redis-server
#CMD ["redis-server", "/etc/redis/redis.conf"]

#CMD [ "/usr/bin/mongod", "--quiet", "--config", "/etc/mongodb.conf", "run" ]


# RUN gem install bundler
# RUN cd ~/next_gen_ion_torrent_ampliseq_hotspot_pipeline
# RUN bundle install
