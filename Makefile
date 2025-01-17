install:
	@docker run -it -w /data -v ${PWD}:/data:delegated -v ~/.composer:/root/.composer:delegated --entrypoint composer --rm registry.gitlab.com/grahamcampbell/php:8.0-base update
	@docker run -it -w /data -v ${PWD}:/data:delegated -v ~/.composer:/root/.composer:delegated --entrypoint composer --rm registry.gitlab.com/grahamcampbell/php:8.0-base bin all update

phpunit:
	@docker run -it -w /data -v ${PWD}:/data:delegated --entrypoint vendor/bin/phpunit --rm registry.gitlab.com/grahamcampbell/php:8.0-cli

phpstan-analyze:
	@docker run -it -w /data -v ${PWD}:/data:delegated --entrypoint vendor/bin/phpstan --rm registry.gitlab.com/grahamcampbell/php:8.0-cli analyze

phpstan-baseline:
	@docker run -it -w /data -v ${PWD}:/data:delegated --entrypoint vendor/bin/phpstan --rm registry.gitlab.com/grahamcampbell/php:8.0-cli analyze --generate-baseline

psalm-analyze:
	@docker run -it -w /data -v ${PWD}:/data:delegated --entrypoint vendor/bin/psalm.phar --rm registry.gitlab.com/grahamcampbell/php:8.0-cli

psalm-baseline:
	@docker run -it -w /data -v ${PWD}:/data:delegated --entrypoint vendor/bin/psalm.phar --rm registry.gitlab.com/grahamcampbell/php:8.0-cli --set-baseline=psalm-baseline.xml

psalm-show-info:
	@docker run -it -w /data -v ${PWD}:/data:delegated --entrypoint vendor/bin/psalm.phar --rm registry.gitlab.com/grahamcampbell/php:8.0-cli --show-info=true

test: phpunit phpstan-analyze psalm-analyze

clean:
	@rm -rf .phpunit.result.cache composer.lock vendor vendor-bin/*/composer.lock vendor-bin/*/vendor
