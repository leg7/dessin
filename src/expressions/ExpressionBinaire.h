#pragma once
#include "Expression.h"
#include <memory>

class ExpressionBinaire: public Expression
{
	enum class Operation
	{
		ADD,
		SUB,
		MUL,
		DIV,
		EQ,
		GT,
		GE,
		LT,
		LE,
	};
	std::shared_ptr<Expression> _gauche, _droite;
	Operation _op;

	public:
	ExpressionBinaire(const std::shared_ptr<Expression> &gauche, const std::shared_ptr<Expression> &droite, Operation op): _gauche(gauche), _droite(droite), _op(op){}

	Expression& operator==(Expression const &e) const;
	Expression& operator>(Expression const &e) const;
	Expression& operator>=(Expression const &e) const;
	Expression& operator<(Expression const &e) const;
	Expression& operator<=(Expression const &e) const;
	Expression& operator+(Expression const &e) const;
	Expression& operator-(Expression const &e) const;
	Expression& operator*(Expression const &e) const;
	Expression& operator/(Expression const &e) const;

	std::shared_ptr<Element> calculer() const noexcept override;
};
