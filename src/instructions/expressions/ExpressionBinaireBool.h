#pragma once
#include "ExpressionBinaire.h"

class ExpressionBinaireBool: public ExpressionBinaire
{
	enum class Operation
	{
	};

	public:
	ExpressionBinaireBool(Expression gauche, Expression droite, Operation op): ExpressionBinaire(gauche, droite, op) {}
	bool calculer() const noexcept;
};
