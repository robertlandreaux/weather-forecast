FROM ruby:3.4.5-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    postgresql-client \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Create tmp directories
RUN mkdir -p tmp/pids tmp/sockets

# Precompile assets (optional, can be skipped for API-only apps)
# RUN bundle exec bootsnap precompile --gemfile

# Expose port 3000 for web server
EXPOSE 3000

# Default command
CMD ["bundle", "exec", "puma"]