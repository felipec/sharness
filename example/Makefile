T = $(wildcard *.t)

test: $(T)
	$(MAKE) clean

$(T): clean
	./$@ $(TEST_OPTS)

clean:
	rm -fr 'trash directory'.* test-results

.PHONY: test $(T) clean
