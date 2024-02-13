#pragma once
#include "Valeure.h"
#include "../elements/Element.h"

class Constante: public Valeure
{
	Element _val;
	public:
	Constante(Element val): _val(val) {}
	virtual Element val() const noexcept override { return _val; };
};
