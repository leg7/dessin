#pragma once

#include "../elements/Element.h"
#include <memory>

class Expression
{
	public:
	virtual std::shared_ptr<Element> eval() const noexcept = 0;
};
