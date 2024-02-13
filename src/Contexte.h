#pragma once
#include <map>
#include <string>
#include "elements/Element.h"

class Contexte
{
	std::map<std::string, Element> data;

	public:
	bool add(const std::string &nom, const Element &e) noexcept;
	bool rm(const std::string &nom);
};
