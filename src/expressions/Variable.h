#pragma once
#include <memory>
#include "Expression.h"
#include "../elements/Element.h"
#include "../Contexte.h"

class Variable: public Expression
{
	protected:
	// ptr to Element of contexte
	std::shared_ptr<Contexte> _c;
	std::string _key;

	public:
	Variable(const std::shared_ptr<Contexte> &c, const std::string &key): _c(c), _key(key) {}
	virtual std::shared_ptr<Element> eval() const noexcept override { return _c->at(_key); };
};
