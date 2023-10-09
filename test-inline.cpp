#include <iostream>

struct A {
	void foo();
	void pika();

	inline int bar() {
		return 4;
	}

	static inline int static_foo() {
		return 5;
	}

	template <int N>
	inline void template_bar() {
		std::cout << N;
	}
};

inline void A::foo() {
	std::cout << "foo";
}

void A::pika() {
	std::cout << "pika";
}