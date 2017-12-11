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



#### Daum Webtoon

다음 웹툰에서 제공하는 웹툰 데이터는 json으로 파싱할 수 있는데 url 구조가 다음과 같다.

`url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/mon?timeStamp=1512997936178"`

`/list_serialized`까지가 기본 url인 것 같고 `/mon`부분부터 와일드카드와 파라미터를 쓰게끔 되어 있는 것 같다. 파라미터로 넘어가는 것은 현재시간을 숫자형식으로 바꿔준 것이고, 루비에서는 `Time.now.to_i`로 쉽게 만들어 낼 수 있다. 와일드 카드 부분은 요일을 영어로 바꾼 것의 앞의 3글자인데 이 역시 루비에서 기본적으로 제공하는 기능인 `.strftime('%a')`로 추출할 수 있다. 그래서 완성된 url 코드는 다음과 같다.

```ruby
timestamp = Time.now.to_i
week_day = Date.today.strftime('%a').downcase
url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/" + week_day + "?timeStamp=" + timestamp.to_s
```

String interpolation 을 사용해서 다음과 같이 만들 수도 있다.

```ruby
url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/#{week_day}?timeStamp=#{timestamp.to_s}"
```

받아온 json 파일을 `#{timestamp}.json`파일에 저장하고 `timestamp`는 메소드의 리턴값으로 사용한다. 그리고 `/webtoon`에서 해당 리턴값을 받아 파일을 읽는데에 사용한다.

