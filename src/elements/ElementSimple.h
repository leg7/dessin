#pragma once
#include "Element.h"
#include "../expressions/Expression.h"

class ElementSimple: public Element
{
	double _val;
	std::shared_ptr<Expression> _val_expr;

	public:
	ElementSimple(double val): _val(val), _val_expr(nullptr) { }
	ElementSimple(std::shared_ptr<Expression> const &val_expr): _val_expr(val_expr) {}
	virtual double toDouble() const noexcept override { if (_val_expr) return _val_expr->eval()->toDouble(); else return _val; }
	virtual Type type() const noexcept override { return Type::ElementSimple; }
};
