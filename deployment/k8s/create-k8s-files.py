#!/usr/bin/env python3

import os

import click
from jinja2 import Template


def write_deployment_def(template, output, name, version):
    print(f"Creating deployment definition name={name}, version={version}")
    with(open(template, 'rt')) as f:
        template = Template(f.read())
        with(open(output, 'wt')) as out:
            out.write(template.render(name=name, version=version))
        print(f"Wrote {os.path.abspath(output)}")


@click.command()
@click.option('--version', default='latest', help='Docker image version')
def cli(version):
    write_deployment_def('deployment-template.yml', f"deployment-{version}.yml", "expressjs-app-template", version)


if __name__ == '__main__':
    cli()
