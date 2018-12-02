User.create!([
  {username: "alanturing", password: "turingmachine", date_created: nil, salt: "$2a$10$YSfQIlVyk2fK6L/5eas2Bu"},
  {username: "adalovelace", password: "analyticalengine", date_created: nil, salt: "$2a$10$3EGS7S4wgflHNrUfGSlR7e"},
  {username: "linustorvalds", password: "linuxmasterrace", date_created: nil, salt: "$2a$10$11/1QqRlFfu2Jb/rI0BUrPO"},
  {username: "egrelayson", password: "qwerty", date_created: nil, salt: "$2a$10$4vavmTri9f3uIIQX1Djza."}
])
ResourceThread.create!([
  {title: "CCNA 2018", description: "What resources did you use to study?", user_id: 1, resource_count: 1},
  {title: "MySQL", description: "Where should I start?", user_id: 11, resource_count: 11},
  {title: "TensorFlow Basics", description: "", user_id: 21, resource_count: 0},
  {title: "Science & Technology", description: "Overview, Philosophy, & History of Science & Technology", user_id: 31, resource_count: 6},
  {title: "The Philippine linguistic situation", description: "Classification of Philippine languages, Endangered and extinct languages in the Philippines", user_id: 31, resource_count: 11}
])
Folder.create!([
  {name: "Cisco", resource_thread_id: 1},
  {name: "for noobs", resource_thread_id: 11},
  {name: "for later", resource_thread_id: 11},
  {name: "Downloadable online", resource_thread_id: 31},
  {name: "Available at UP Libraries ", resource_thread_id: 31}
])
Keyword.create!([
  {text: "Computer Networks", instances: 1},
  {text: "Database Systems", instances: 1},
  {text: "Artificial Intelligence", instances: 1},
  {text: "science", instances: 1},
  {text: "technology", instances: 1},
  {text: "linguistics", instances: 1},
  {text: "philippines", instances: 1},
  {text: "language", instances: 1},
  {text: "dialect", instances: 1}
])
Resource.create!([
  {trust: 100.0, text: "https://www.cisco.com/c/en/us/training-events/training-certifications/certifications/associate/ccna-routing-switching.html#~stickynav=6", resource_thread_id: 1, user_id: 21},
  {trust: 100.0, text: "Use PostgreSQL instead.", resource_thread_id: 11, user_id: 11},
  {trust: 100.0, text: "https://www.tutorialspoint.com/mysql/", resource_thread_id: 11, user_id: 21},
  {trust: 100.0, text: "Kuhn, T. 1962. The Nature of Scientific Revolutions.", resource_thread_id: 31, user_id: 31},
  {trust: 100.0, text: "Steward, J. 1955. Theory of Culture Change: The Methodology of Multilinear Evolution. University of Illinois Press, Chicago.", resource_thread_id: 31, user_id: 31},
  {trust: 100.0, text: "C. Sagan. (1997). (Chapter 1) \"Can we know the universe?\" in \"Science and Its Ways of Knowing\", Hatton, J. and P. Ploufe (eds.). Prentice Hall ", resource_thread_id: 31, user_id: 31},
  {trust: 100.0, text: "Klemke et. al. (1998). Introductory Readings in the Philosophy of Science, Prometheus Books, New York.", resource_thread_id: 31, user_id: 31},
  {trust: 100.0, text: "McGinn, R. (1991).(Chapter 1) \"Why study Science, Technology in Society?\" in Science, Technology and Society. Pearson.", resource_thread_id: 31, user_id: 31},
  {trust: 100.0, text: "McGinn, R. (1991).(Chapter 2) \"Science and Technology ,their nature and relationships?\" in Science, Technology and Society. Pearson.(1997)", resource_thread_id: 31, user_id: 31},
  {trust: 100.0, text: "Language map of the Philippines; Quakenbush, 1998: 1-22, PPT", resource_thread_id: 5, user_id: 31},
  {trust: 100.0, text: "https://blog.senti.com.ph/the-philippine-linguistic-situation-18a69f14a1b7", resource_thread_id: 5, user_id: 31}
])
Rfile.create!([
  {resource_id: 1, folder_id: 1},
  {resource_id: 21, folder_id: 11},
  {resource_id: 21, folder_id: 21},
  {resource_id: 5, folder_id: 31},
  {resource_id: 6, folder_id: 31},
  {resource_id: 7, folder_id: 31},
  {resource_id: 8, folder_id: 5},
  {resource_id: 9, folder_id: 5},
  {resource_id: 10, folder_id: 5}
])
Tag.create!([
  {resource_thread_id: 1, keyword_id: 1},
  {resource_thread_id: 11, keyword_id: 11},
  {resource_thread_id: 21, keyword_id: 21},
  {resource_thread_id: 31, keyword_id: 31},
  {resource_thread_id: 31, keyword_id: 5},
  {resource_thread_id: 5, keyword_id: 6},
  {resource_thread_id: 5, keyword_id: 7},
  {resource_thread_id: 5, keyword_id: 8},
  {resource_thread_id: 5, keyword_id: 9}
])
Vote.create!([
  {value: "up", user_id: 11, resource_id: 21},
  {value: "up", user_id: 21, resource_id: 1}
])
