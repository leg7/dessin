#pragma once
#include "Expression.h"
#include <memory>

class ExpressionBinaire: public Expression
{
	public:
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
		AND,
		OR,
	};

	private:
	std::shared_ptr<Expression> _gauche, _droite;
	Operation _op;

	public:
	ExpressionBinaire(const std::shared_ptr<Expression> &gauche, const std::shared_ptr<Expression> &droite, Operation op): _gauche(gauche), _droite(droite), _op(op){}

	virtual std::shared_ptr<Element> eval() const noexcept override;
};
