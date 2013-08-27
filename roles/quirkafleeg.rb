name "quirkafleeg"
description "quirkafleeg project wrapper role"

default_attributes(
    :project  => 'quirkafleeg',
    :database => 'signon',
    :databags => {
        :primary => 'quirkafleeg'
    },
    :apps     => {
        'signonotron2'     => {
            :deploy_name => 'signon',
            :port        => 3000,
            :mysql_db    => 'signon',
            :migrate     => 'bundle exec rake db:migrate'
        },
        'static'           => {
            :port => 4000
        },
        'panopticon'       => {
            :port     => 5000,
            :mongo_db => 'govuk_content_publisher'
        },
        'publisher'        => {
            :port     => 6000,
            # not sure about this
            :mongo_db => 'govuk_content_publisher'
        },
        'content_api'      => {
            :deploy_name       => 'contentapi',
            :port              => 7000,
            :precompile_assets => false,
            :mongo_db          => 'govuk_content_publisher'
        },
        'people'           => {
            :port => 8000
        },
        'frontend-news'    => {
            :deploy_name => 'news',
            :port        => 10000
        },
        'frontend-www'     => {
            :deploy_name => 'www',
            :port        => 11000
        },
        'frontend-courses' => {
            :deploy_name => 'courses',
            :port        => 12000
        },
        'asset-manager'    => {
            :port     => 13000,
            :mongo_db => 'govuk_content_publisher',
            :precompile_assets => false
        },
    },
    :govuk    => {
        :app_domain => "theodi.org"
    }
)

run_list(
    "recipe[odi-apt]",
    "recipe[build-essential]",
    "recipe[git]",
    "recipe[postfix]",
    "recipe[ntp]",
    "recipe[odi-users]",
    "recipe[odi-pk]",
    "recipe[mysql::client]",
    "recipe[dictionary]",
    "recipe[nodejs::install_from_package]"
)