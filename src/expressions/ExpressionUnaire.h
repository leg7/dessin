#pragma once
#include "Expression.h"

class ExpressionUnaire: public Expression
{
	public:
	enum class Operation
	{
		NEG,
		MIN,
		NOOP,
	};
	private:
	std::shared_ptr<Expression> _operande;
	Operation _operateur;

	public:
	ExpressionUnaire(const std::shared_ptr<Expression> &expr, Operation operateur = Operation::NOOP) noexcept: _operande(expr), _operateur(operateur) {}

	std::shared_ptr<Element> eval() const noexcept override;
};
