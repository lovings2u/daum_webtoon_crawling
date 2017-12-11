## 다음 웹툰 크롤링하기

#### sinatra autoreloader 설정하기

```shell
$ gem install sinatra-contrib
```

*app.rb*

```ruby
require 'sinatra'
require 'sinatra/reloader'
[...]
```

서버 재시작 필요없이 자동으로 재시작 해준다.



#### rest-client 설치하기

```shell
$ gem install rest-client
```

*app.rb*

```ruby
require 'rest-client'
#다음웹툰에서 json형식으로 받아올 예정이기 때문에  json 잼도 추가
require 'json'
```

