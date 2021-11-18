{
  kind: 'pipeline',
  type: 'docker',
  name: 'pdf-template',

  trigger: {
    ref: [
      'refs/heads/master',
      'refs/pull/*/head',
    ],
    event: ['push', 'pull_request'],
  },

  platform: {
    os: 'linux',
    arch: 'amd64',
  },

  steps: [
    {

      name: 'environment',
      image: '549323063936.dkr.ecr.us-east-2.amazonaws.com/nutrien/environment',
      pull: 'never',
      privileged: true,
      when: {
        branch: ['master'],
      },
    },
    {
      name: 'cleanup',
      image: '549323063936.dkr.ecr.us-east-2.amazonaws.com/nutrien/cleanup',
      pull: 'never',
      failure: 'ignore',
      privileged: true,
      when: {
        branch: ['master'],
        status: ['success', 'failure'],
      },
      depends_on: [
        'environment',
      ],
    },
  ],
}
