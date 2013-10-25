name "quirkafleeg-frontend"
description "quirkafleeg frontend wrapper role"

default_attributes(
    :apps => {
        'frontend-www' => {
            :deploy_name  => 'www',
            :port         => 3020,
            :is_default   => true,
            :naked_domain => true,
            :redirects    => {
                "^/about/space$"                              => "/space",
                "^/people$"                                   => "/team",
                "^/people/nrs$"                               => "/team/nigel-shadbolt",
                "^/people/(.*)$"                              => "/team/$1",
                "^/team/board$"                               => "/team",
                "^/team/executive$"                           => "/team",
                "^/team/commercial$"                          => "/team",
                "^/team/technical$"                           => "/team",
                "^/team/operations-team$"                     => "/team",
                "^/join-us$"                                  => "/membership",
                "^/start-up$"                                 => "/start-ups",
                "^/start-up/(.*)$"                            => "/start-ups/$1",
                "^/events/OpenDataChallengeSeries$"           => "/challenge-series",
                "^/content/ODChallengeSeriesDates$"           => "/challenge-series/dates",
                "^/content/crime-and-justice-series$"         => "/challenge-series/crime-and-justice",
                "^/content/energy-and-environment-programme$" => "/challenge-series/energy-and-environment",
                "^/events/gallery$"                           => "/events",
                "^/training$"                                 => "/learning",
                "^/excellence/pg_certificate$"                => "/pg-certificate",
                "^/library$"                                  => "/",
                "^/guide$"                                    => "/guides",
                "^/guide/(.*)$"                               => "/guides/$1",
                "^/case-study$"                               => "/case-studies",
                "^/case-study/(.*)$"                          => "/case-studies/$1-case-study",
                "^/consultation-response$"                    => "/consultation-responses",
                "^/consultation-response/(.*)$"               => "/consultation-responses/$1",
                "^/odi-in-the-news$"                          => "/news",
                "^/feedback$"                                 => "/contact",
                "^/calendar$"                                 => "/events",
                "^/past-events$"                              => "/events",
                "^/content/news-open-data-institute$"         => "/newsletter",
                "^/news/assets$"                              => "/newsroom",
                "^/media-release$"                            => "/media-releases",
                "^/media-release/(.*)$"                       => "/media-releases/$1",
                "^/sites/default/files/360s/(.*)$"            => "/360s/$1",
            }
        },
        #        'people'           => {
        #            :port    => 3000
        #        },
        #        'frontend-news'    => {
        #            :deploy_name => 'news',
        #            :port        => 3010
        #        },
        #        'frontend-courses' => {
        #            :deploy_name => 'courses',
        #            :port        => 3030
        #        },
    }
)

run_list(
    "role[quirkafleeg]"
)