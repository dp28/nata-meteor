gmail =
  username: 'not.another.todo.app'
  password: '!otrofaireconstabulary'

process.env.MAIL_URL = "smtp://#{gmail.username}%40gmail.com:#{gmail.password}@smtp.gmail.com:465/"