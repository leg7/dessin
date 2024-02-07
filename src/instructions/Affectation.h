#include "Instruction.h"
#include "expressions/Expression.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include <memory>

class Affectation: public Instruction
{
	std::shared_ptr<Contexte>;
	static void affecter(Element e, Expression val);
};
