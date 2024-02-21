#pragma once
#include "Element.h"

template<typename T>
class ElementPrimitif: public Element
{
	private:
		T _val;
	public:
		ElementPrimitif(const T val) noexcept: _val(val) {}
		T val() const noexcept { return _val; }
		virtual double toDouble() const noexcept override { return static_cast<double>(_val); }
};
