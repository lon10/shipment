# README

* To run server:
`$ bundle exec rackup`

* To run tests:
`$ bundle exec rspec`

* Run in docker:
* Buid:
  `$ docker build -t shipment:latest .`

* Run:
  `$ docker run -p 9292:9292 -it shipment:latest`

* Try it:
  `GET http://localhost:9292/api`
  `POST http://localhost:9292/api/delivery`

* Swagger:
  `http://localhost:9292/swagger_doc`