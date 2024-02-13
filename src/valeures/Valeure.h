#pragma once
#include "../elements/Element.h"
#include <memory>

class Valeure
{
	public:
	virtual Element val() const noexcept = 0;
};
