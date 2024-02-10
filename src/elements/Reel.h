#pragma once
#include "Element.h"

class Reel: public Element
{
	float _val;
	public:
	Reel(float val) noexcept: Element(Type::Reel), _val(val) {}
	float val() const noexcept { return _val; };
};

