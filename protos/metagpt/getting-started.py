import asyncio

from metagpt.roles import Architect, Engineer, ProductManager, ProjectManager
from metagpt.team import Team


async def startup(idea: str):
    company = Team()
    company.hire(
        [
            ProductManager(),
            Architect(),
            ProjectManager(),
            Engineer(),
        ]
    )
    company.invest(investment=3.0)
    company.run_project(idea=idea)

    await company.run(n_round=5)


asyncio.run(startup(idea="write a cli blackjack game"))
