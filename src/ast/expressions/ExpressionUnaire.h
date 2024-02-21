#pragma once
#include "Expression.h"

class ExpressionUnaire: public Expression
{
	enum class Operation
	{
		NEG,
		MIN,
		NOOP,
	};
	std::shared_ptr<Expression> _operande;
	Operation _operateur;

	public:
	ExpressionUnaire(const std::shared_ptr<Expression> &expr, Operation operateur) noexcept: _operande(expr), _operateur(operateur) {}

	std::shared_ptr<Element> eval() const noexcept override;
};
