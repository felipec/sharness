T = $(wildcard *.t)

test: $(T)
	@$(MAKE) --silent clean

$(T): clean
	./$@ $(TEST_OPTS)

clean:
	@rm -fr 'trash directory'.* test-results

.PHONY: test $(T) clean
